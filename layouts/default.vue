<template>
  <div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
      <a class="navbar-brand" href="/">Bhouse</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <NuxtLink to="/houses" class="nav-link">房子</NuxtLink>
          </li>
          <li class="nav-item">
            <NuxtLink to="/" class="nav-link">地图</NuxtLink>
          </li>
        </ul>
      </div>
    </nav>
    <Nuxt />
    <b-sidebar title="房子信息" v-model="isHouseOpen" width="50%"  right shadow @hidden="closeHouse()">
      <House :house_id="houseId"></House>
    </b-sidebar>
    <b-sidebar title="小区信息" v-model="isGardenOpen" width="40%"  left shadow @hidden="closeGarden()">
      <Garden :garden_id="gardenId"></Garden>
    </b-sidebar>
  </div>
</template>
<script>
import House from "@/components/house"
export default {
  components: {House},
  data: function(){
    return {
      isHouseOpen: false,
      isGardenOpen: false
    }
  },
  computed: {
    houseId: function(){
      return this.$store.state.house_id;
    },
    gardenId: function(){
      return this.$store.state.garden_id;
    }
  },
  methods: {
    closeHouse(){
      this.$store.commit("setHouseId", null)
    },
    closeGarden(){
      this.$store.commit("setGardenId", null)
    }
  },
  watch: {
    houseId: function(new_v, old_v){
      if(!!new_v){
        this.isHouseOpen = true
      }else {
        this.isHouseOpen = false
      }
    },
    gardenId: function(new_v, old_v){
      if(!!new_v){
        this.isGardenOpen = true
      }else {
        this.isGardenOpen = false
      }
    }
  }
}
</script>
<style>
  .container-fluid {
    height: 100%;
    padding: 0;
  }
</style>
