require '../templates/partials/head_partial'

class Template
    def render(data)
        head_partial = HeadPartial.new

        <<-TEMPLATE
        <html land="en">
            <head>
                <title>Noise Inc | Record #{data['record'][1].text}</title>
                #{head_partial.render}
            </head>
            <body>
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Record #{data['record'][1].text}</h1>
                            </div>
                        </div>
                    </div>
			    </div>
                <main class="main-content">	
                    <div class="container" style="margin-top:30px;">
                        <div class="row">
                            <div class="col-md-6 col-sm-12">
                                <div class="record-img">
                                    <!-- 
                                            Records pictures downloaded from
                                            http://bavotasan.com/2008/6-free-vinyl-record-vectors/ 
                                            Made by: by c.bavota 
                                        -->
                                    <img src="#{data['record'][3].text}" alt="#{data['record'][3].text}">
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <div class="record-description">
                                    <p style="color:#{data['record'][7].attributes['color']};">#{data['record'][7].text}</p>
                                </div>
                                <a 
                                    href="/records/#{data['record'][1].text}/interest"
                                    class="interest-btn"
                                    onMouseOver="
                                        this.style.backgroundColor = '#{data['record'][7].attributes['color']}';
                                        this.style.border = '2px solid #{data['record'][9].attributes['background']}';
                                        this.style.color = '#{data['record'][9].attributes['background']}';
                                    "
                                    onMouseOut="
                                        this.style.backgroundColor = '#{data['record'][9].attributes['background']}';
                                        this.style.border = '2px solid #{data['record'][7].attributes['color']}';
                                        this.style.color = '#{data['record'][7].attributes['color']}';
                                    "
                                    style="
			                            background-color: #{data['record'][9].attributes['background']};
                                        border: 2px solid #{data['record'][7].attributes['color']};
			                            color: #{data['record'][7].attributes['color']};
                                    "
                                ><i class="fa fa-star fa-lg"></i>Express Interest</a>
                        </div>
                        </div>
                    </div>
                </main>
                <footer>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="bktohp-btn"href="/">Back to Home page</a>
                            </div>
                        </div>
                    </div>	
		        </footer>
            </body>
        </html>
        TEMPLATE
    end
end
