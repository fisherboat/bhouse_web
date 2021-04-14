<template>
  <div id="garden-detail" v-if="garden">
    <strong class="name">{{garden.name}}</strong>
    <div class="row mt-2">
      <div class="col-md-6 item">
        <div class="label">区域</div>
        <div class="content">{{garden.region}}</div>
      </div>

      <div class="col-md-6 item">
        <div class="label">地址</div>
        <div class="content">{{garden.address}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">平均房价</div>
        <div class="content" v-if="garden.average_price">{{garden.average_price.toFixed(2)}}万</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">房子数量</div>
        <div class="content">{{garden.houses_count}}</div>
      </div>
    </div>
    <table class="table mt-3">
      <thead>
        <tr class="table-active">
          <th scope="col">面积</th>
          <th scope="col">金额</th>
          <th scope="col">房型</th>
          <th scope="col">装修</th>
          <th scope="col">楼层</th>
          <th scope="col"></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="house in garden.houses" :key="house.id">
          <td scope="col">{{house.area}}</td>
          <td scope="col">{{house.amount}}</td>
          <td scope="col">{{house.house_type}}</td>
          <td scope="col">{{house.decoration}}</td>
          <td scope="col">{{house.floor}}</td>
          <td scope="col">
            <span class="text-primary" style="cursor: pointer;" @click="showHouse(house.id)">查看</span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  props: ["garden_id"],
  data: function(){
    return {
      garden: null,
    }
  },
  mounted(){
    this.loadGarden();
  },
  methods: {
    loadGarden(){
      if(!this.garden_id){
        return
      }
      var self = this
      self.$store.dispatch("loadGarden", this.garden_id).then(function(resp){
        self.garden = resp.data
      });
    },
    showHouse(house_id){
      var self = this
      self.$store.commit("setHouseId", house_id)
    },
  },
  watch: {
    garden_id: function(new_v, old_v){
      this.loadGarden();
    }
  }
}
</script>
<style lang="scss">
  #garden-detail {
    padding: 1rem 1.5rem;
    .item {
      display: flex;
      padding: 0.5rem 1rem;
      .label {
        font-weight: 500;
        color: #000000;
        margin-right: 1rem;
        &::after {
          content: " : "
        }
      }
      .content {
        color: #000000;
      }
    }
  }
</style>