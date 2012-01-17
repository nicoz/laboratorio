class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected
    
    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, link(page, page, :rel => "#"), :class => "active")
      end
    end
    
    def previous_or_next_page(page, text, classname)
      
      cl = 'prev' if classname == 'previous_page'
      cl = 'next' if classname == 'next_page'
      
      if page
        tag(:li, link(text, page), :class => cl)
      else
        tag(:li, link(text, "#"), :class => cl + ' disabled')
      end
    end
    
    def gap()
    	tag(:li, link("...", "#"), :class => 'disabled')
    end
    
    def html_container(html)
      tag(:ul, html)
    end
    
end
