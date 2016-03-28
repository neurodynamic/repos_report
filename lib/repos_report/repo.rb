require 'colorize'

class Repo
  attr_accessor :directory

  def initialize(directory)
    @directory = directory
  end

  def project_name_length
    project_name.length
  end

  def concise_status(error_indentation)
    if issues.any?
      message_with_issues(error_indentation).red
    else
      message_with_no_issues(error_indentation).green
    end
  end



  private

  def project_name
    @directory.split("/").last
  end

  def message_with_issues(error_indentation)
    project_name + whitespace_padding(error_indentation) + issues.join(', ')
  end

  def message_with_no_issues(error_indentation)
    project_name + whitespace_padding(error_indentation) + 'ALL GOOD'
  end

  def whitespace_padding(error_indentation)
    ' ' * (error_indentation - project_name_length)
  end

  def issues
    [
      unpulled_or_unpushed_commits, 
      uncommitted_changes
    ].compact
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