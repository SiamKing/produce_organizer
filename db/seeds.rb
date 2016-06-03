produce_list = {
  "Bananas" => {
    shelf_life: 5
  },
  "Strawberries" => {
    shelf_life: 3
  },
  "Broccoli" => {
    shelf_life: 10
  },
  "Bok Choy" => {
    shelf_life: 7
  },
  "Kale" => {
    shelf_life: 5
  },
  "Cucumbers" => {
    shelf_life: 6
  },
  "Onions" => {
    shelf_life: 30
  },
  "Carrots" => {
    shelf_life: 14
  },
  "Potatoes" => {
    shelf_life: 30
  },

}

produce_list.each do |name, produce_hash|
  p = ProduceDatabase.new
  p.name = name
  produce_hash.each do |attribute, value|
    p[attribute] = value
  end
  p.save
end
