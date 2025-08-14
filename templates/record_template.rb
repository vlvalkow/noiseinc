require '../templates/partials/head_partial'
require '../templates/partials/header_partial'

class Template
    def render(data)
        head_partial = HeadPartial.new
        header_partial = HeaderPartial.new
        record = data['record']
        related = data['related_records']
        <<-TEMPLATE
        <html land="en">
            <head>
                <title>Noise Inc | Record #{record.elements['id'].text}</title>
                #{head_partial.render}
            </head>
            <body>
                #{header_partial.render({'username' => data['username']})}
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Record #{record.elements['id'].text}</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <main class="main-content">
                    <div class="container" style="margin-top:30px;">
                        <div class="row" style="margin-bottom:30px;">
                            <div class="col-md-6">
                                <div class="record-img" style="background-color:#{record.elements['image'].attributes['background']};">
                                    <img src="#{record.elements['image'].text}" alt="record alt text">
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <div class="record-description">
                                    <p style="color:#{record.elements['description'].attributes['color']};">#{record.elements['description'].text}</p>
                                </div>
                                <a 
                                    href="/records/#{record.elements['id'].text}/interest"
                                    class="interest-btn"
                                    onMouseOver="
                                        this.style.backgroundColor = '#{record.elements['description'].attributes['color']}';
                                        this.style.border = '2px solid #{record.elements['interest'].attributes['background']}';
                                        this.style.color = '#{record.elements['interest'].attributes['background']}';
                                    "
                                    onMouseOut="
                                        this.style.backgroundColor = '#{record.elements['interest'].attributes['background']}';
                                        this.style.border = '2px solid #{record.elements['description'].attributes['color']}';
                                        this.style.color = '#{record.elements['description'].attributes['color']}';
                                    "
                                    style="
                                        background-color: #{record.elements['interest'].attributes['background']};
                                        border: 2px solid #{record.elements['description'].attributes['color']};
                                        color: #{record.elements['description'].attributes['color']};
                                    "
                                ><i class="fa fa-star fa-lg"></i>Express Interest</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h2 style="color: #C6C6C6">Related Records</h2>
                            </div>
                        </div>
                        <div class="row">
                            #{related.map do |r|
                                <<-REL
                                <div class="col-md-3" style="padding-left:9px; padding-right:9px;">
                                    <div class="record record-list">
                                        <div class="record-img" style="background-color:#{r.elements['image'].attributes['background']};">
                                            <img src="#{r.elements['image'].text}" alt="record alt text">
                                        </div>
                                        <div class="record-title">
                                            <h2>#{r.elements['rtitle'].text}</h2>
                                        </div>
                                        <a class="view-record-btn" href="/records/#{r.elements['id'].text}">View record</a>
                                    </div>
                                </div>
                                REL
                            end.join}
                        </div>
                    </div>
                </main>
                <footer>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <a class="bktohp-btn" href="/">Back to Home page</a>
                            </div>
                        </div>
                    </div>    
                </footer>
            </body>
        </html>
        TEMPLATE
    end
end
