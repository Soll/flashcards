 require "open-uri"
	require "nokogiri"


	url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
	html = open(url)
	doc = Nokogiri::HTML(html)

	row = doc.xpath("//tr")
	
	row.each do |cell|
	  nodes_count = 0;
	  
	  cell.css("td").take(3).each do |node| 
	    if nodes_count == 0
	    	 @id = node.text.split(".").first.to_i
	    end

	    if nodes_count == 1
	    	 @o_t = node.text
	    end

	    if nodes_count == 2
	    	@t_t = node.text
	    end

	    nodes_count =+ 1  
	  end 	
	Card.create(:id @id, :original_text @o_t, :translated_text @t_t, :review_date @r_d)
	end 
	
