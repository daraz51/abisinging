class StaticPagesController < ApplicationController
 
  before_filter :set_meta
  
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def testimonials
  end

  def weddings
  end

  def events 
  end
  
  def set_meta
    @page_description = 'Singing teacher / tutor covering the Portsmouth, Drayton, Havant and surronding areas. Both mobile and studio based singing lessons are avaible.'
    @page_keywords = 'Singing,Teacher,Tutor,Portsmouth,Havant,Drayton,Waterlooville,Fareham,Lessons'
    set_meta_tags :og => {
                          :title    => 'Abi Singing',
                          :type     => 'article',
                          :url      => 'http://www.abisinging.co.uk',
                          :image    => 'http://www.abisinging.co.uk/assets/logo_header.png',
                          :description => 'Qualified Singing Teacher in and around the Portsmouth area'
                          } 
    set_meta_tags :twitter => {
                              :card => 'summary',
                              :site => '@abisinging',
                              :url => 'www.abisinging.co.uk',
                              :image    => 'http://www.abisinging.co.uk/assets/logo_header_120.png'
                               }              
  end
  
end
