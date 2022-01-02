<template>
  <div id="house-detail" v-if="house">
    <strong class="name">{{house.name}}</strong>
    <div class="row mt-2">
      <div class="col-md-6 item">
        <div class="label">区域</div>
        <div class="content">{{house.region}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">小区</div>
        <div class="content">{{house.garden_name}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">地址</div>
        <div class="content">{{house.address}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">房价</div>
        <div class="content">{{house.amount}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">房屋类型</div>
        <div class="content">{{house.house_type}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">所在楼层</div>
        <div class="content">{{house.floor}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">面积</div>
        <div class="content">{{house.area}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">户型结构</div>
        <div class="content">{{house.structure}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">装修</div>
        <div class="content">{{house.decoration}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">朝向</div>
        <div class="content">{{house.direction}}</div>
      </div>
      <div class="col-md-6 item">
        <div class="label">电梯</div>
        <div class="content">{{house.elevator}}</div>
      </div>
    </div>
    <b-card no-body>
      <b-tabs card>
        <b-tab title="图片" active>
          <b-carousel id="carousel-pictures" v-model="slide" :interval="4000" controls indicators background="#ababab" img-width="1024" img-height="480" style="text-shadow: 1px 1px 2px #333;">
            <template v-for="(picture, index) in house.pictures">
              <b-carousel-slide :img-src="picture" :key="index"></b-carousel-slide>
            </template>
          </b-carousel>
        </b-tab>
        <b-tab title="价格">
          <table class="table">
            <thead>
              <tr>
                <th>日期</th><th>价格</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="price in sortedPrices" :key="price.id">
                <td>{{$moment(price.Date).format('YYYY-MM-DD')}}</td><td>{{price.amount}} {{price.amount > 50 ? "万" : "亿"}} </td>
              </tr>
            </tbody>
          </table>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>
<script>
export default {
  props: ["house_id"],
  data: function(){
    return {
      house: null,
      slide: 0,
    }
  },
  mounted(){
    this.loadHouse();
  },
  computed: {
    sortedPrices: function(){
      return this.house.prices.sort((a, b) => b.id - a.id );
    }
  },
  methods: {
    loadHouse(){
      if(!this.house_id){
        return
      }
      var self = this
      self.$store.dispatch("loadHouse", this.house_id).then(function(resp){
        self.house = resp.data
      });
    },

  },
  watch: {
    house_id: function(new_v, old_v){
      this.loadHouse();
      this.slide = 0
    },

  }
}
</script>
<style lang="scss">
  #house-detail {
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