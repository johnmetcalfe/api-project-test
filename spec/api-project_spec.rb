describe "api-project" do

  before(:all) do
    #@driver = Selenium::WebDriver.for :chrome
    @email = "john.metcalfe@skybettingandgaming.com"
    @password = "password"
    #@url = "http://178.62.40.209:3000/games/"
    #@driver.get @url
 end

 it "Valid creating new book" do

   book1 = HTTParty.post("http://localhost:3000/books", body:{title: "Test Book 1", body: "Test Body"})
   r = HTTParty.get("http://178.62.40.209:3000/books/57e5897d6600c00ec01385cf")
   books = HTTParty.get("http://localhost:3000/books")
   parse_page = Nokogiri::HTML(books)
   books_array = []
   parse_page.css('.content').css('div').map do |a|
     post_id = a['id']
     books_array.push(post_id)
   end
   expect(books.code).to eq 200
   expect(books.message).to eq "OK"
   expect(books.body).to include "Test Book 1"
   expect(books.body).to include "Test Body"
   HTTParty.delete("http://localhost:3000/books/#{books_array[-1]}")

 end


  it "add a new game check it exists and delete it" do
    exit
    create_game("Test Game", "Test Body")
    #Check voucher Exists
    page = @driver.page_source
    expect(page.to_s).to include @title, @body
    #Delete Voucher
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(2)").click

  end

  it "add a new book check it exists" do
    create_book("Test Book", "Test Body")
    #Check Book Exists
    page = @driver.page_source
    expect(page.to_s).to include @title, @body
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(2)").click

  end

  it "Login create a new game and check it exists then edit and check the edit is update, then delete the voucher" do
    create_game("Test Game", "Test Body")
    #Check Voucher exists
    page = @driver.page_source
    expect(page.to_s).to include @title, @body
    #Edit the voucher
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > a").click
    @driver.find_element(css: "body > div > form > input[type='text']:nth-child(3)").send_keys " Updated"
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(7)").click
    #Check updated exists
    page_updated = @driver.page_source
    expect(page_updated.to_s).to include "#{@title} Updated", @body
    #Delete Updated Voucher
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(2)").click

  end

  it "Login create a new voucher and check it exists then edit and check the edit is update, then delete the voucher" do
    create_book("Test Book", "Test Body")
    #Check Book exists
    page = @driver.page_source
    expect(page.to_s).to include @title, @body
    #Edit the Book
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > a").click
    @driver.find_element(css: "body > div > form > input[type='text']:nth-child(3)").send_keys " Updated"
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(7)").click
    #Check updated exists
    page_updated = @driver.page_source
    expect(page_updated.to_s).to include "#{@title} Updated", @body
    #Delete Updated Book
    links = @driver.find_elements(css: ".content a")
    links[-1].click
    @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(2)").click
  end

  # it "login and add a new voucher check it exists and delete it" do
  #   create_game("g", "g")
  #   #Check voucher Exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include "Game validation failed"
  #
  # end
  #
  # it "login and add a invalid book check error exists" do
  #   create_book("g", "g")
  #   #Check Book Exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include "Book validation failed"
  #
  # end
  #
  # it "Login create a new voucher and check it exists then edit and check the edit is update, then delete the voucher" do
  #   create_voucher("Test Voucher", "Test Body", 5)
  #   #Check Voucher exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include @title, @body, @rating.to_s
  #   #Edit the voucher
  #   @driver.find_element(css: "body > fieldset > a").click
  #   @driver.find_element(css: "body > form > input[type='text']:nth-child(2)").send_keys ""
  #   @driver.find_element(css: "body > form > input[type='text']:nth-child(2)").send_keys "g"
  #   @driver.find_element(css: "body > form > input[type='submit']:nth-child(5)").click
  #   #Check updated exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include "Voucher validation failed"
  #
  # end
  #
  # it "Login create a new voucher and check it exists then edit and check the edit is update, then delete the voucher" do
  #   create_book("Test Book", "Test Body", 5)
  #   #Check Book exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include @title, @body, @rating.to_s
  #   #Edit the Book
  #   @driver.find_element(css: "body > fieldset > a").click
  #   @driver.find_element(css: "body > form > input[type='text']:nth-child(2)").send_keys " Updated"
  #   @driver.find_element(css: "body > form > input[type='submit']:nth-child(5)").click
  #   #Check updated exists
  #   page = @driver.page_source
  #   expect(page.to_s).to include "Book validation failed"
  #
  # end

  after(:all) do
    @driver.quit
  end

end
