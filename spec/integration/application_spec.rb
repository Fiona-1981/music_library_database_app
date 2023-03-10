require "spec_helper"
require "rack/test"
require_relative '../../app'


def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_2' })
  connection.exec(seed_sql)
end

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_2' })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  
    context "POST /albums" do
      xit "should create a new album" do 

        response = post('/albums', 
        title: 'Voyager', 
        release_year: 2022, 
        artist_id: 2)

        expect(response.status).to eq(200)
        expect(response.body).to eq("")

        response = get('/albums')
        expect(response.body).to include('Voyager')

      end 
    end

    
    context 'GET /artists' do 
      xit "returns all artists listed" do

        response = get("/artists")

        expect(response.status).to eq(200)
        expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
      end
    end 


    context "POST /artists" do 
      xit "creates a new artist in the database" do 

        response = post("/artists", 
        name: "Wild nothing",
        genre: "Indie"
        )

        expect(response.status).to eq(200)
        expect(response.body).to eq("")

        response = get('/artists')
      
        expect(response.status).to eq(200)
        expect(response.body).to include('Wild nothing')
      end
    end

    context "GET /albums/:id" do
      xit "returns the HTML content for a single album 2" do
      
        response = get('/albums/2')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Surfer Rosa</h1>')
        expect(response.body).to include('Release year: 1988')
      end 
    end

  context "GET /albums" do
    xit "returns all albums" do
      
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include("Surfer Rosa")
    end 
  end

  context "GET /artists/:id" do
    it "returns an HTML page showing a single artist details" do
    
      response = get('/artists/2')
      
      expect(response.status).to eq(200)
      expect(response.body).to include("ABBA")
      # expect(response.body).to include("Rock")
    end 
  end

end