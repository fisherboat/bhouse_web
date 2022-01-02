function loadRegions({ commit, state }, params) {

  return this.$axios({
    method: "GET",
    url: `/cities/1/regions`,
    params: params
  });
}

function loadGardens({ commit, state }, params) {
  return this.$axios({
    method: "GET",
    url: `/cities/1/gardens`,
    params: {region: params.region, bedrooms: params.bedrooms}
  });
}

function loadGarden({ commit, state }, id) {
  return this.$axios({
    method: "GET",
    url: `/gardens/${id}`
  });
}


function loadHouses({ commit, state }, params) {
  return this.$axios({
    method: "GET",
    url: `/cities/1/houses`,
    params: params
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
  loadHouse,
  loadGardens,
  loadGarden
}