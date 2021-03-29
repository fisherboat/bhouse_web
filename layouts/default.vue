<template>
  <div class="container-fluid">
    <Nuxt />
    <b-sidebar title="房子信息" v-model="isSidebarOpen" width="50%"  right shadow @hidden="closeSidebar()">
      <House :house_id="houseId"></House>
    </b-sidebar>
  </div>
</template>
<script>
import House from "@/components/house"
export default {
  components: {House},
  data: function(){
    return {
      isSidebarOpen: false
    }
  },
  computed: {
    houseId: function(){
      return this.$store.state.house_id;
    }
  },
  methods: {
    closeSidebar(){
      this.$store.commit("setHouseId", null)
    }
  },
  watch: {
    houseId: function(new_v, old_v){
      if(!!new_v){
        this.isSidebarOpen = true
      }else {
        this.isSidebarOpen = false
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
