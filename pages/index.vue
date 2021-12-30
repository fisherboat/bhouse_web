<template>
<div class="page">
  <amap id='map' ref="map" :center="center" :zoom="13">
    <amap-marker v-for="g in gardens" :position="[g.longitude, g.latitude]" :label="{content: `${g.name}(${g.average_price.toFixed(2)}万)`, direction: 'top' }" :icon="require(`~/assets/image/gander.png`)" :key="g.id" @click="showGarden(g.id)" />
  </amap>
  <div id='search' class="rounded shadow">
    <b-form-select id="input-3" v-model="region" :options="regions" required ></b-form-select>
    <b-form-select id="input-4" class="mt-1" v-model="bedrooms" :options="bedrooms_options" required ></b-form-select>
    garden count: {{gardens.length}}
  </div>
</div>

</template>

<script>

export default {
  data: function(){
    return {
      map: null,
      region: "徐汇区",
      bedrooms: 2,
      houses: [],
      bedrooms_options: [{value: 0, text: "0 室户"}, {value: 1, text: "1 室户"},{value: 2, text: "2 室户"},{value: 3, text: "3 室户"},{value: 4, text: "4 室户"}],
      regions: [],
      markers: [],
      center: [121.433333, 31.183333],
      gardens: [],
    }
  },
  mounted(){
    this.initMap();
    this.loadRegions();
  },
  methods: {
    initMap(){
      this.loadGardens();
    },
    loadGardens(){
      var params = {region: this.region, bedrooms: this.bedrooms}
      var self = this
      self.$store.dispatch("loadGardens", params).then(function(resp){
        self.gardens = resp.data
        if(self.houses.length > 0){
          var g = self.gardens[0]
          self.center = [g.longitude, g.latitude]
        }
      });
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

    showGarden(garden_id){
      var self = this
      self.$store.commit("setGardenId", garden_id)
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
      this.loadGardens()
    },
    bedrooms: function(){
      this.loadGardens()
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
    padding: .5rem;
    top: 4rem;
    left: 1rem;
    position: absolute;
    height: 8rem;
    width: 15rem;
    line-height: 2rem;
    background-color: ghostwhite;
  }
}
</style>
