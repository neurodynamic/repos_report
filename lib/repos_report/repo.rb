require_relative 'repo_class'
require 'colorize'

class Repo
  attr_accessor :directory

  def initialize(directory)
    @directory = directory
  end

  def project_name_length
    @directory.split("/").last.length
  end

  def concise_status(error_indentation)
    project_name = @directory.split('/').last

    error_indentation = error_indentation
    whitespace_after_project_name = ' '*(error_indentation - project_name.length)

    message = project_name
    issues = [
      unpulled_or_unpushed_commits, 
      uncommitted_changes
      ].compact.join(', ')


    if unpulled_or_unpushed_commits or 
        uncommitted_changes

      message = "#{message}#{whitespace_after_project_name}#{issues}".red
    else
      message = "#{message}#{whitespace_after_project_name}ALL GOOD".green
    end

    message
  end

  def unpulled_or_unpushed_commits

    ahead_or_behind = `cd #{@directory}; git for-each-ref --format="%(upstream:track) %(upstream:short)" | grep origin/master`

    if ahead_or_behind.include? 'ahead'
      'UNPUSHED COMMITS'
    elsif ahead_or_behind.include? 'behind'
      'UNPULLED COMMITS'
    elsif `cd #{@directory}; git remote`.include? 'origin'
      nil
    else
      'NO REMOTE ORIGIN'
    end
  end

  def uncommitted_changes
    changes = false

    changes = true if `cd #{@directory}; git status | grep 'Changes not staged for commit'`.length > 0
    changes = true if `cd #{@directory}; git status | grep 'Changes to be committed'`.length > 0
    changes = true if `cd #{@directory}; git status | grep 'Untracked files'`.length > 0

    changes ? "UNCOMMITTED CHANGES" : nil
  end
end