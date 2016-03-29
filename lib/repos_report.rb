require_relative 'repos_report/repo_finder'

module ReposReport
  class << self
    def print_status_of_projects_under(directory)
      repos = RepoFinder.repos_in_or_below(directory)

      puts_repo_data(repos) do |repo|
        @padding ||= whitespace_padding_for(repos)
        repo.concise_status(@padding)
      end
    end

    def list_all_repos(directory)
      repos = RepoFinder.repos_in_or_below(directory)

      puts_repo_data(repos, &:directory)
    end

    private

    def puts_repo_data(repos, &block)
      if repos.any?
        puts
        puts_all(repos, &block)
        puts
      else
        puts "No repos found."
      end
    end

    def puts_all(items, &stringy_block)
      items.each do |item|
        puts stringy_block.call(item)
      end
    end

    def whitespace_padding_for(repos)
      longest_repo_project_name(repos) + 3
    end

    def longest_repo_project_name(array_of_repos)
      array_of_repos.map(&:project_name_length).max
    end
  end
end
