module Locomotive
  class PagePresenter < BasePresenter

    delegate :title, :slug, :fullpath, :handle, :raw_template, :published, :listed, :wildcard, :wildcards, :redirect, :redirect_url, :template_changed, :cache_strategy, :response_type, :to => :source

    def escaped_raw_template
      h(self.source.raw_template)
    end

    def editable_elements
      self.source.enabled_editable_elements.collect(&:as_json)
    end

    def included_methods
      super + %w(title slug fullpath handle raw_template published listed wildcard wildcards redirect redirect_url cache_strategy response_type template_changed editable_elements localized_fullpaths)
    end

    def localized_fullpaths
      site = self.source.site

      {}.tap do |hash|
        site.locales.each do |locale|
          hash[locale] = site.localized_page_fullpath(self.source, locale)
        end
      end
    end

    def as_json_for_html_view
      methods = included_methods.clone - %w(raw_template)
      self.as_json(methods)
    end

  end
end