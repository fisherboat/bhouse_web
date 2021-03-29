function loadRegions({ commit, state }, params) {
  return this.$axios({
    method: "GET",
    url: `/cities/1/regions`,
    params: {region: params.region}
  });
}

function loadHouses({ commit, state }, params) {
  return this.$axios({
    method: "GET",
    url: `/cities/1/houses`,
    params: {region: params.region}
  });
}


function loadHouse({ commit, state }, id) {
  return this.$axios({
    method: "GET",
    url: `/houses/${id}`
  });
}



export default {
  loadRegions,
  loadHouses,
  loadHouse
}