require 'colorize'

class Repo
  attr_accessor :directory

  def initialize(directory)
    @directory = directory
  end

  def project_name_length
    project_name.length
  end

  def concise_status(whitespace_padding)
    set_git_variables # Not needed unless this method is run

    if issues.any?
      message_with_issues(whitespace_padding).red
    else
      message_with_no_issues(whitespace_padding).green
    end
  end



  private

  def project_name
    @directory.split("/").last
  end

  def set_git_variables
    @origin_master_output ||= `cd #{@directory}; git for-each-ref --format="%(upstream:track) %(upstream:short)" | grep origin/master`
    @git_remote_output ||= `cd #{@directory}; git remote`
    @git_status_output ||= `cd #{@directory}; git status`
  end

  def message_with_issues(whitespace_padding)
    project_name.ljust(whitespace_padding) + issues.join(', ')
  end

  def message_with_no_issues(whitespace_padding)
    project_name.ljust(whitespace_padding) + 'ALL GOOD'
  end

  def issues
    issue_array = []
    issue_array << 'UNPUSHED COMMITS' if @origin_master_output.include? 'ahead'
    issue_array << 'UNPULLED COMMITS' if @origin_master_output.include? 'behind'
    issue_array << 'NO REMOTE ORIGIN' unless @git_remote_output.include? 'origin'
    issue_array << 'UNCOMMITTED CHANGES' if @git_status_output =~ uncommitted_changes_regex
    issue_array
  end

  def uncommitted_changes_regex
    /(Changes not staged for commit)|(Changes to be committed)|(Untracked files)/
  end
end