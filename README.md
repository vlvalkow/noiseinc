# Noise Inc

This is a refactored version of the NoiseInc project on the university_project branch using only standard Ruby libraries.

```bash
docker build -t vlvalkow/noiseinc-refactoring-cgi .
```

```bash
docker run -dp 80:80 -v "%cd%:/usr/local/apache2/htdocs" vlvalkow/noiseinc-refactoring-cgi
```

Visit [http://localhost](http://localhost) in your browser.
