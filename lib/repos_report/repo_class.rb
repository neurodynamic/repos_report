class Repo
  class << self

    def find_all_in_or_below(directory)
      if folders_with_repos_in(directory).sort == folders_in(directory).sort
        find_all_in(directory)
      else
        repos = find_all_in(directory)

        folders_without_repos_in(directory).each do |folder|
          repos += find_all_in_or_below(folder)
        end

        repos
      end
    end

    def find_all_in(directory)
      return [] if folders_in(directory).empty?

      folders_with_repos_in(directory).map { |d| Repo.new(d) }
    end

    def indentation_of_status_for(repos)
      longest_project_name = repos.map(&:project_name_length).max
      longest_project_name + 3
    end 



    private

    def contains_repo?(directory_path)
      Dir.glob("#{directory_path}/.git").any?
    end

    def folders_without_repos_in(directory)
      directories = folders_in(directory)

      directories.reject { |d| contains_repo?(d) }
    end

    def folders_with_repos_in(directory)
      directories = folders_in(directory)
      directories.select { |d| contains_repo?(d) }
    end

    def folders_in(directory)
      Dir.glob("#{directory}/*")
    end
  end
end