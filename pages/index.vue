<template>
<div class="page">
  <amap id='map' ref="map" :center="center" :zoom="13">
    <amap-marker v-for="h in houses" :position="[h.longitude, h.latitude]" :label="{content: '¥' + h.amount, direction: 'top' }" :key="h.id" @click="showHouse(h.id)" />
  </amap>
  <div id='search' class="rounded shadow">
    <b-form-select id="input-3" v-model="region" :options="regions" required ></b-form-select>
    houses count: {{houses.length}}
  </div>
</div>

</template>

<script>

// import mapboxgl from 'mapbox-gl';
// import MapboxLanguage  from '@mapbox/mapbox-gl-language'
export default {
  data: function(){
    return {
      map: null,
      region: "徐汇区",
      houses: [],
      regions: [],
      markers: [],
      center: [],
    }
  },
  mounted(){
    this.initMap();
    this.loadRegions();
  },
  methods: {
    initMap(){
      this.loadHouses();
    },
    loadHouses(){
      var params = {region: this.region}
      var self = this
      self.$store.dispatch("loadHouses", params).then(function(resp){
        self.houses = resp.data
        var h = self.houses[0]
        if(self.houses.length > 0){
          self.center = [h.longitude, h.latitude]
        }
      });
    },

    showHouse(house_id){
      var self = this
      self.$store.commit("setHouseId", house_id)
    },
    removeMarkers(){
      for (var i = this.markers.length - 1; i >= 0; i--) {
        this.markers[i].remove();
      }
    },
    loadRegions(){
      var params = {}
      var self = this
      self.$store.dispatch("loadRegions", params).then(function(resp){
        self.regions = resp.data
      });
    }
  },
  watch: {
    region: function(){
      this.loadHouses()
    }
  }
}
</script>

<style lang="scss">
.page{
  height: 100%;
  #map{
    height: 100%;
  }
  #search {
    padding: 0.5rem;
    top: 1rem;
    left: 1rem;
    position: absolute;
    height: 5rem;
    width: 15rem;
    line-height: 2rem;
    background-color: ghostwhite;
  }
}
</style>
