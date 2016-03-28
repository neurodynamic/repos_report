require_relative 'repo'

module RepoFinder
  class << self

    def repos_in_or_below(directory)
      if all_child_folders_have_repos(directory) # Base case
        repos_in(directory)

      else
        repos = repos_in(directory)

        folders_without_repos_in(directory).each do |folder|
          repos += repos_in_or_below(folder)
        end

        repos
      end
    end



    private

    def repos_in(directory)
      return [] if folders_in(directory).empty?

      folders_with_repos_in(directory).map { |d| Repo.new(d) }
    end

    def folders_without_repos_in(directory)
      directories = folders_in(directory)

      directories.reject { |d| contains_repo?(d) }
    end

    def folders_with_repos_in(directory)
      directories = folders_in(directory)
      directories.select { |d| contains_repo?(d) }
    end

    def all_child_folders_have_repos(directory)
      folders_with_repos_in(directory).sort == folders_in(directory).sort
    end

    def contains_repo?(directory_path)
      Dir.glob("#{directory_path}/.git").any?
    end

    def folders_in(directory)
      Dir.glob("#{directory}/*")
    end
  end
end