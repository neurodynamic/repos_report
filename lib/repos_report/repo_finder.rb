require_relative 'repo'

module RepoFinder
  class << self

    def repos_in_or_below(directory)
      repos_in(directory) + repos_in_subdirectories_of(directory)
    end



    private

    def repos_in(directory)
      folders_with_repos_in(directory).map { |d| Repo.new(d) }
    end

    def folders_with_repos_in(directory)
      directories = subdirectories_in(directory)
      directories.select { |d| contains_repo?(d) }
    end

    def repos_in_subdirectories_of(directory)
      subdirectories = subdirectories_in(directory)

      subdirectories.reduce([]) do |repos, subdirectory| 
        repos += repos_in_or_below(subdirectory)
      end
    end

    def contains_repo?(directory_path)
      Dir.glob("#{directory_path}/.git").any?
    end

    def subdirectories_in(directory)
      Dir.glob("#{directory}/*")
    end
  end
end