class NameValidator < ActiveModel::Validator
  def validate(record)
    if is_name_exist(record)
      record.errors.add :base, "Name #{record.name} should be unique on Vertical and Categories"
    end
  end

  private

    def is_name_exist(record)
      Vertical.where(name: record.name).exists? || Category.where(name: record.name).exists?
    end
end
