Facter.add(:node_profile) do
  confine :operatingsystem => 'AristaEOS'
  confine :feature => :rbeapi

  has_weight 100
  setcode do
    require 'rbeapi/client'

    node = Rbeapi::Client.connect_to('localhost')
    neighbors = node.enable('show lldp neighbors')

    if neighbors[0][:encoding] == "json"
      # Reformat to the following data structure:
      # lldp_neighbors => {"Management1"=>[
      #                                    {"ttl"=>120, "neighborDevice"=>"switch1", "neighborPort"=>"Management1", "port"=>"Management1"},
      #                                    {"ttl"=>120, "neighborDevice"=>"Switch2", "neighborPort"=>"Management1", "port"=>"Management1"}
      #                                   ],
      #                    "Ethernet2"=>[
      #                                  {"ttl"=>120, "neighborDevice"=>"Switch3", "neighborPort"=>"Ethernet2/8", "port"=>"Ethernet2"}
      #                                 ]
      #                   }
      newhash = Hash.new { |hash, key| hash[key] = [] }
      neighbors[0][:result]['lldpNeighbors'].each { |n| newhash[n['port']]<<n }

      node_profile = nil

      newhash.each do |key, value|
        if ( /leaf/ =~ value[0]["neighborDevice"] )
          node_profile = 'spine'
        end
      end

      # Return the value to facter
      node_profile
    end
  end
end

Facter.add(:node_profile) do
  confine :operatingsystem => 'AristaEOS'
  confine :feature => :rbeapi

  has_weight 50
  setcode do
    require 'rbeapi/client'

    node = Rbeapi::Client.connect_to('localhost')
    neighbors = node.enable('show lldp neighbors')

    if neighbors[0][:encoding] == "json"
      newhash = Hash.new { |hash, key| hash[key] = [] }
      neighbors[0][:result]['lldpNeighbors'].each { |n| newhash[n['port']]<<n }

      node_profile = nil

      newhash.each do |key, value|
        if ( /spine/ =~ value[0]["neighborDevice"] )
          node_profile = 'leaf'
        end
      end

      # Return the value to facter
      node_profile
    end
  end
end

Facter.add(:node_profile) do
  confine :operatingsystem => 'AristaEOS'
  confine :feature => :rbeapi

  setcode do
    'unknown'
  end
end
