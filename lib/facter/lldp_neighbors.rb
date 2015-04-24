Facter.add('lldp_neighbors') do
  confine :operatingsystem => "AristaEOS"

  setcode do
    require 'rbeapi/client'

    node = Rbeapi::Client.connect_to('localhost')
    neighbors = node.enable('show lldp neighbors')

    #require pp
    #[{:command=>"show lldp neighbors",
    #  :result=>{"tablesDrops"=>0, "tablesDeletes"=>0, "tablesInserts"=>3,
    #            "lldpNeighbors"=>[
    #                               {"ttl"=>120, "neighborDevice"=>"switch1", "neighborPort"=>"Management1", "port"=>"Management1"},
    #                               {"ttl"=>120, "neighborDevice"=>"switch2", "neighborPort"=>"Management1", "port"=>"Management1"},
    #                               {"ttl"=>120, "neighborDevice"=>"switch3", "neighborPort"=>"Ethernet2/8", "port"=>"Ethernet2"}

    #                             ],
    #            "tablesLastChangeTime"=>1428337835.11, "tablesAgeOuts"=>0
    #           },
    #  :encoding=>"json"}
    #]

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
      neighbors[0][:result]["lldpNeighbors"].each { |n| newhash[n["port"]]<<n }
      # Return the hash to facter
      newhash
    end
  end
end
