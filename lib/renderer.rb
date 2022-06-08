class Renderer
    def render(template, data = {})
        require '../templates/' + template
        template = Template.new
        template.render data
    end
end
