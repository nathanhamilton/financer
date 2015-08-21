module MinicalSetter
  def self.included(klass)
    klass.class_eval do
      klass.columns.each do |column|
        if column.type == :date
          define_method "minical_#{column.name}=" do |date|
            if date.blank?
              self.send("#{column.name}=", '')
            else
              self.send("#{column.name}=", Date.strptime(date, "%m/%d/%Y"))
            end
          end
          define_method "minical_#{column.name}" do
            self.send("#{column.name}").to_s(:USA) unless self.send("#{column.name}").nil?
          end
        end
      end
    end
  end
end
