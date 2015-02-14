require_relative 'repos_report/repo'

module ReposReport
	def self.print_status_of_projects_under(directory)
			
    repos = Repo.find_all_in_or_below(directory)

    puts "\nSTATUS OF REPOS:\n\n"

    repos.each do |r|
      puts r.concise_status(Repo.indentation_of_status_for(repos))
    end
	end
end
