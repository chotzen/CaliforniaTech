class AddIssueVolumeNumberDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :issues, :issue, -> { Issue.current_issue }
    change_column_default :issues, :volume, -> { Issue.current_volume }
  end
end
