<template>
<div class="page px-3 pt-5">
  <div class="filters p-2 border rounded mt-3">
    <div class="row">
        <div class="col-1 form-group">
        <label for="InputRegion">行政区</label>
        <b-form-select v-model="search.region" :options="regions" id="InputRegion" ></b-form-select>
      </div>
      <div class="col-2 form-group">
        <label for="InputGardenName">小区</label>
        <input type="text" class="form-control" v-model="search.garden_name" id="InputGardenName">
      </div>
      <div class="col-1 form-group">
        <label for="InputBedrooms">卧室</label>
        <b-form-select v-model="search.bedrooms" :options="bedrooms_options" id="InputRegion" ></b-form-select>
      </div>
      <div class="col-1 form-group">
        <label for="InputLivingRooms">客厅</label>
        <b-form-select v-model="search.living_rooms" :options="living_rooms_options" id="InputLivingRooms" ></b-form-select>
      </div>
      <div class="col-2 form-group">
        <label for="InputArea">面积</label>
        <div class="row">
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.min_area" id="InputArea">
          </div>
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.max_area" id="InputArea">
          </div>
        </div>
      </div>
      <div class="col-2 form-group">
        <label for="InputAmount">价格</label>
        <div class="row">
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.min_amount" id="InputAmount">
          </div>
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.max_amount" id="InputAmount">
          </div>
        </div>
      </div>
      <div class="col-2 form-group">
        <label for="InputGrowthRate">涨价幅度</label>
        <div class="row">
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.min_growth_rate"  id="InputGrowthRate">
          </div>
          <div class="col-6">
            <input type="text" class="form-control" v-model="search.max_growth_rate"  id="InputGrowthRate">
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="result mt-2 border p-2 rounded">
    <table class="table table-hover">
      <thead>
        <tr>
          <th scope="col">Uid</th>
          <th scope="col">行政区</th>
          <th scope="col">小区</th>
          <th scope="col">名称</th>
          <th scope="col">楼层</th>
          <th scope="col">户型</th>
          <th scope="col">面积</th>
          <th scope="col">价格</th>
          <th scope="col">涨价幅度</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="house in houses" :key="house.id">
          <td>
            <a :href="`https://sh.lianjia.com/ershoufang/${house.uid}.html`">{{house.uid}}</a>
          </td>
          <td>{{house.region}}</td>
          <td>
            <span class="cursor-pointer text-primary" @click="showGarden(house.GardenId)">{{house.garden_name}}</span>
          </td>
          <td>
            <span class="cursor-pointer text-primary" @click="showHouse(house.id)">{{house.name}}</span>

          </td>
          <td>{{house.floor}}</td>
          <td>{{house.house_type}}</td>
          <td>{{house.area}}</td>
          <td>{{house.amount}} {{house.amount > 50 ? "万" : "亿"}}</td>
          <td>{{house.growth_rate}}</td>
        </tr>
      </tbody>
    </table>
      <b-pagination v-model="search.page" :total-rows="search.total_rows" :per-page="search.page_size" aria-controls="my-table"></b-pagination>
  </div>
</div>
</template>

<script>

export default {
  data: function(){
    return {
      houses: [],
      search: {region: "闵行区", bedrooms: null, living_rooms: null, page: 1, page_size: 20, total_rows: 0},
      sort: {field: "growth_rate", kind: "ASC"},
      regions: [],
      bedrooms_options: [
        { value: null, text: '选择卧室数' },
        { value: 1, text: '一室' },
        { value: 2, text: '二室' },
        { value: 3, text: '三室' },
        { value: 4, text: '四室'}
      ],
      living_rooms_options: [
        { value: null, text: '选择客厅数' },
        { value: 1, text: '一厅' },
        { value: 2, text: '二厅' },
        { value: 3, text: '三厅' },
      ]
    }
  },
  mounted(){
    this.loadHouses()
    this.loadRegions()
  },
  methods: {
    loadHouses(){
      var params = JSON.parse(JSON.stringify(this.search))
      params.sort = `${this.sort.field} ${this.sort.kind}`
      var self = this
      self.$store.dispatch("loadHouses", params).then(function(resp){
        self.houses = resp.data.houses
        self.search.total_rows = resp.data.total_rows
      });
    },
    showGarden(garden_id){
      var self = this
      self.$store.commit("setGardenId", garden_id)
    },
    showHouse(house_id){
      var self = this
      self.$store.commit("setHouseId", house_id)
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
    search: {
      handler(newName, oldName) {
        if(!!newName){
          this.loadHouses()
        }
      },
      deep: true
    }
  }
}
</script>
<style lang="scss">

</style>
