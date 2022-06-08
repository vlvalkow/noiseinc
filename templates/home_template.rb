require '../templates/partials/head_partial'

class Template
    def render(data)
        head_partial = HeadPartial.new

        <<-TEMPLATE
        <html land="en">
            <head>
                <title>Noise Inc | Home</title>
                #{head_partial.render}
            </head>
            <body>
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Catalogue</h1>
                            </div>
                        </div>
                    </div>
			    </div>
                <main class="main-content">	
                    <div class="container" style="margin-top:30px;">
                        <div class="row">
                            #{data['records'].map do |record|
                                <<-RECORD
                                <div class="col-md-3" style="padding-left:9px; padding-right:9px;">
                                    <div class="record record-list">
                                        <div class="record-img" style="background-color:#{record[3].attributes["background"]};">
                                            <!-- 
                                            Records pictures downloaded from
                                            http://bavotasan.com/2008/6-free-vinyl-record-vectors/ 
                                            Made by: by c.bavota 
                                            -->
                                            <!-- get the forth child node of the record element (represents the image of the record) -->
                                            <img src="#{record[3].text}" alt="record alt text">
                                        </div>
                                        <div class="record-title">
                                            <!-- get the sixth child node of the record element (represents the title of the record) -->
                                            <h2>#{record[5].text}</h2>
                                        </div>
                                        <!-- 
                                        <div class="record-description">
                                            get the eight child node of the record element (represents the description of the record) 
                                            <p>#{record[7].text}</p>
                                        </div>
                                        -->
                                        <!-- get the second child node of the record element (represents the id of the record) -->
                                        <a class="view-record-btn" href="/records/#{record[1].text}">View record</a>
                                    </div>
                                </div>
                                RECORD
                            end.join}
                        </div>
                    </div>
                </main>
                <footer>
                
                </footer>
            </body>
        </html>
        TEMPLATE
    end
end
