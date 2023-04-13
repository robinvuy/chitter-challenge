require_relative 'peep'

class PeepRepository
  def all
    peeps = []

    # Send the SQL query and get the result set.
    sql = 'SELECT id, peep, time FROM chitters;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    # The result set is an array of hashes.
    # Loop through it to create a model
    # object for each record hash.
    result_set.each do |record|

      # Create a new model object
      # with the record data.
      peep = Peep.new
      peep.id = record['id'].to_i
      peep.peep = record['peep']
      peep.time = record['time']

      peeps << peep
    end

    return peeps
  end

  def find(id)
    sql = 'SELECT id, peep, time FROM chitters WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    peep = Peep.new
    peep.id = result_set[0]['id'].to_i
    peep.peep = result_set[0]['peep']
    peep.time = result_set[0]['time']

    return peep
  end

  def create(peep)
    sql = 'INSERT INTO chitters (message, time) VALUES ($1, $2);'
    result_set = DatabaseConnection.exec_params(sql, [peep.message, peep.time])

    return peep
  end
end