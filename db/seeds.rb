# db/seeds.rb
zip_code_logs = [
  { zip_code: '01001-000', state: 'SP', city: 'São Paulo', district: 'Centro', search_count: 2 },
  { zip_code: '01002-000', state: 'SP', city: 'São Paulo', district: 'Liberdade', search_count:  2},
  { zip_code: '01003-000', state: 'SP', city: 'São Paulo', district: 'Paulista', search_count:2  },
  { zip_code: '02001-000', state: 'RJ', city: 'Rio de Janeiro', district: 'Centro', search_count: 2 },
  { zip_code: '02002-000', state: 'RJ', city: 'Rio de Janeiro', district: 'Copacabana', search_count: 1 },
  { zip_code: '02003-000', state: 'RJ', city: 'Rio de Janeiro', district: 'Botafogo', search_count:  1},
  { zip_code: '03001-000', state: 'MG', city: 'Belo Horizonte', district: 'Centro', search_count: 1 },
  { zip_code: '03002-000', state: 'MG', city: 'Belo Horizonte', district: 'Savassi', search_count: 1 },
  { zip_code: '03003-000', state: 'MG', city: 'Belo Horizonte', district: 'Funcionários', search_count: 1 }
]

zip_code_logs.each do |log|
  ZipCodeLog.create!(log)
end
