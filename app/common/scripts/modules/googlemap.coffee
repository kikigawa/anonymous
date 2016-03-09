###
使い方
#map-canvasを要素を作成
###

class GoogleMap
  constructor: ->
    trace "Google Map"
    @data = @mapData()
    
    @init()
    $(window).on "load", =>
      @loaded()
    
  

  init: =>
    script = $("script[type='text/javascript']")[0]
    $(script).before('<script src="https://maps.googleapis.com/maps/api/js" type="text/javascript"></script>')


  loaded: =>
    canvas = document.getElementById "map-canvas"

    $(canvas).css({
      "width"  : "400px"
      "height" : "200px"
      })
    mapOptions =
      zoom: 14
      center: new google.maps.LatLng 35.792621, 139.806513
      mapTypeControl: false
      zoomControl: false
      streetViewControl: false
    
    map = new google.maps.Map canvas , mapOptions



    #マーカー分、繰り返し
    markers = []
    for k,v of @data.marker
      m = new google.maps.Marker
        position : new google.maps.LatLng(v.lat, v.lng),
        map: map
        icon: new google.maps.MarkerImage(
          v.img
          new google.maps.Size(v.size, v.size)
          new google.maps.Point(0, 0)
          new google.maps.Point(v.size/2, v.size)
          new google.maps.Size(v.size, v.size)
        )
        url: v.url
        animation: google.maps.Animation.DROP
      m.addListener "click", ->
        trace this
        $(location).attr "href", this.url




    trace @data.design
    map.set("styles", @data.design)



  mapData: =>
    return data =
      marker:
        tokyo:
          img: "/common/images/googlemap-marker-icon.png"
          size: 30
          lat: 35.792621
          lng: 139.806513
          url: location.origin+"?q=1"
        tokyo2:
          img: "/common/images/googlemap-marker-icon.png"
          size: 40
          lat: 35.79
          lng: 139.80
          url: location.origin+"?q=2"


      design:
        [
            {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#e9e9e9"
                    },
                    {
                        "lightness": 17
                    }
                ]
            },
            {
                "featureType": "landscape",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f5f5f5"
                    },
                    {
                        "lightness": 20
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#ffffff"
                    },
                    {
                        "lightness": 17
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#ffffff"
                    },
                    {
                        "lightness": 29
                    },
                    {
                        "weight": 0.2
                    }
                ]
            },
            {
                "featureType": "road.arterial",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#ffffff"
                    },
                    {
                        "lightness": 18
                    }
                ]
            },
            {
                "featureType": "road.local",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#ffffff"
                    },
                    {
                        "lightness": 16
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f5f5f5"
                    },
                    {
                        "lightness": 21
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dedede"
                    },
                    {
                        "lightness": 21
                    }
                ]
            },
            {
                "elementType": "labels.text.stroke",
                "stylers": [
                    {
                        "visibility": "on"
                    },
                    {
                        "color": "#ffffff"
                    },
                    {
                        "lightness": 16
                    }
                ]
            },
            {
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "saturation": 36
                    },
                    {
                        "color": "#333333"
                    },
                    {
                        "lightness": 40
                    }
                ]
            },
            {
                "elementType": "labels.icon",
                "stylers": [
                    {
                        "visibility": "off"
                    }
                ]
            },
            {
                "featureType": "transit",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f2f2f2"
                    },
                    {
                        "lightness": 19
                    }
                ]
            },
            {
                "featureType": "administrative",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#fefefe"
                    },
                    {
                        "lightness": 20
                    }
                ]
            },
            {
                "featureType": "administrative",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#fefefe"
                    },
                    {
                        "lightness": 17
                    },
                    {
                        "weight": 1.2
                    }
                ]
            }
        ]





module.exports = GoogleMap
