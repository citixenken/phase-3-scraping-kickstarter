require 'nokogiri'
require 'pry'

def create_project_hash
  # open file and read it into a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  # binding.pry
  # Data
  # ====
  # projects: kickstarter.css('li.project.grid_4')
  # title: project.css('h2.bbcard_name strong a').text
  # image: project.css('div.project-thumbnail a img').attribute('src').value
  # description: project.css('p.bbcard_blurb').text
  # location: project.css('span.location-name').text
  # percent_funded: project.css('li.first.funded strong').text.gsub('%','').to_i

  projects = {}

  # Iterate through the projects
  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      :image_link => project.css('div.project-thumbnail a img').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text,
      :location => project.css('span.location-name').text,
      :percent_funded => project.css('li.first.funded strong').text.gsub('%','').to_i
    }
  end

  #return projects hash
  projects
end

create_project_hash