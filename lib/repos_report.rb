require_relative 'repos_report/repo_finder'

module ReposReport
  class << self
    def print_status_of_projects_under(directory)
  		
      repos = RepoFinder.repos_in_or_below(directory)

      if repos.any?
        padding_amount = whitespace_padding_for(repos)

        puts

        repos.each do |r|
          puts r.concise_status(padding_amount)
        end

        puts
      else
        puts "No repos found in this directory."
      end
    end

    def list_all_repos(directory)
      repos = RepoFinder.repos_in_or_below(directory)

      puts

      repos.each do |repo|
        puts repo.directory
      end

      puts
    end

    private

    def whitespace_padding_for(repos)
      longest_repo_project_name(repos) + 3
    end

    def longest_repo_project_name(array_of_repos)
      array_of_repos.map(&:project_name_length).max
    end
  end
end
