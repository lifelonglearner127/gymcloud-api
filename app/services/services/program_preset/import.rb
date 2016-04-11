module Services
module ProgramPreset

class Import < BaseService

  def run
    import
  end

  def input_params
    %i(user program_preset)
  end

  private

  def import
    ActiveRecord::Base.transaction do
      @program_preset.program_templates.map do |program_template|
        duplicate(program_template)
      end
    end
  end

  def duplicate(program_template)
    Services::TemplateDuplicating::Program.!(
      program: program_template,
      user: @user,
      folder_id: @user.programs_folder.id
    )
  end

end

end
end
