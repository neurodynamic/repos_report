require_relative 'repos_report/repo_finder'

module ReposReport
  class << self
    def print_status_of_projects_under(directory)
      repos = RepoFinder.repos_in_or_below(directory)

      if repos.any?
        print_statuses_of(repos)
      else
        puts "No repos found in this directory."
      end
    end

    def list_all_repos(directory)
      repos = RepoFinder.repos_in_or_below(directory)

      newline_pad_output do
        repos.each do |repo|
          puts repo.directory
        end
      end
    end

    private

    def print_statuses_of(repos)
      padding_amount = whitespace_padding_for(repos)

      newline_pad_output do
        repos.each do |r|
          puts r.concise_status(padding_amount)
        end
      end
    end

    def whitespace_padding_for(repos)
      longest_repo_project_name(repos) + 3
    end

    def newline_pad_output
      puts; yield; puts
    end

    def longest_repo_project_name(array_of_repos)
      array_of_repos.map(&:project_name_length).max
    end
  end
end
