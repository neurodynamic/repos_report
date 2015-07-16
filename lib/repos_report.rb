require_relative 'repos_report/repo'

module ReposReport
  def self.print_status_of_projects_under(directory)
			
    repos = Repo.find_all_in_or_below(directory)

    puts

    repos.each do |r|
      puts r.concise_status(Repo.indentation_of_status_for(repos))
    end

    puts
  end

  def self.list_all_repos(directory)
    repos = Repo.find_all_in_or_below(directory)

    puts

    repos.each do |repo|
      puts repo.directory
    end

    puts
  end
end
