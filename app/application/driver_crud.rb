class DriverCrud
  def initialize; end

  def self.retrive_all
    Driver.all
  end

  def insert(params)
    Driver.create!(
      license: params[:license],
      name: params[:name],
    )
  end
end
