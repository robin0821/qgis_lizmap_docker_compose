1. Generate the vector tiles
* Tippecanoe is used to generate the vector tiles, the input format has to be geojson. The output file is *.mbtiles.
* Tippecanoe supports multiple layers of mbtiles which can be very useful in styling stage.
* docker pull jskeates/tippecanoe
* docker run -it -v $HOME/tippecanoe:/home/tippecanoe jskeates/tippecanoe:latest
* cmd: tippecanoe -o output.mbtiles input1.geojson input2.geojson input3.geojson input4.geojson

2. Style the vector tiles
* Maputnik editor is used for sytling the vector tiles.
* git clone https://github.com/maputnik/editor.git
* To make is run locally on browser, a simple http-server needs to be started. 
* sudo apt-get install nodejs
* sudo apt-get install npm
* sudo npm install -g http-server
* http-server -p 8000
* Note: the http-server needs to be started within the Maputnik folder

3. Host the vector tiles
* tileserver-gl is used to host the vector tiles
* docker pull klokantech/tileserver-gl
* docker run --rm -it -v $(pwd):/data -p 8080:80 klokantech/tileserver-gl
* In order to use customized style. A config.json file needs to be configured.
* sample config.json is as below:
{
  "options": {
    "paths": {
      "root": "/data",
      "styles": "styles",
      "mbtiles": "/data"
    },
    "domains": [
      "localhost:8888",
      "127.0.0.1:8888",
      "192.168.1.222:8888"
    ]
  },
  "styles": {
    "attractiveness": {
      "style": "style.json"
    }
  },
  "data": {
    "heatmap": {
      "mbtiles": "heatmap.mbtiles"
    }
  }
}
