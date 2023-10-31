FactoryBot.define do
  factory :purchase_address do
    postal_code     { '111-1111' }
    region_id       { '2' }
    city            { 'さいたま市' }
    block           { '本町1-1' }
    building_name   { 'トキワ荘102' }
    phone_number    { '09012345678' }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
