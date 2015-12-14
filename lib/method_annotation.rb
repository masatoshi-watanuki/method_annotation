require "method_annotation/version"
require 'active_support'
require 'active_support/core_ext'

module MethodAnnotation
  class Base
    class << self
      attr_accessor :before_procs, :after_procs, :around_procs, :list, :annotation_name, :describe

      def before(&block)
        (@before_procs ||= []) << block
      end

      def after(&block)
        (@after_procs ||= []) << block
      end
      
      def around(&block)
        (@around_procs ||= []) << block
      end
    end
  end

  concern :Enable do
    def self.included(klass)
      Module.new.tap do |mod|
        klass.prepend(mod)
        klass._prepended_module = mod
      end

      # includeしたクラスが継承された場合もMethodAnnotaionを有効にする
      klass.class_eval do
        def self.inherited(subclass)
          Module.new.tap do |mod|
            subclass.prepend(mod)
            subclass._prepended_module = mod
          end
        end
      end
    end

    class_methods do
      attr_accessor  :_prepended_module, :_annotations

      def method_added(name)
        if @_annotations.present?
          annotations = @_annotations
          _prepended_module.module_eval do

            define_method(name) do |*args, &block|
              annotation_map = annotations.each_with_object({}) do |annotation, hash|
                # 宣言した[class, method_name]をリストに追加する
                (annotation.list ||= []) << [self.class, name.to_sym]
                %i(before_procs around_procs after_procs).each do |proc_name|
                  (hash[proc_name] ||= []).push(*annotation.send(proc_name))
                end
              end

              annotation_map[:before_procs].try(:each) { |blk| instance_exec(*args, &blk) }
              original = ->(*params) { instance_eval { super(*params, &block) } }
              if annotation_map[:around_procs].present?
                chain = annotation_map[:around_procs].reverse.inject(original) do |block_chain, blk|
                  ->(*params) { instance_exec(block_chain, *params, &blk) }
                end
                return_value = instance_exec(*args, &chain)
              else
                return_value = original.call(*args)
              end
              annotation_map[:after_procs].try(:each) { |blk| instance_exec(*args, &blk) }
              return_value
            end

          end
        end
        @_annotations = nil
      end
    
      def method_missing(method, *args)
        annotation = MethodAnnotation::Base.subclasses.find do |c|
          puts method
          puts c.annotation_name
          c.annotation_name == method.to_s || (c.name == method.to_s.classify)
        end
        if annotation
          (@_annotations ||= []) << annotation
        else
          super
        end
      end
    end
  end
end
