export default function({ store,req,redirect, app: { $axios } }) {
  $axios.defaults.baseURL = process.env.BASE_URL
  $axios.defaults.headers.common["Access-Control-Allow-Origin"] = "*";
  $axios.defaults.headers["Accept"] = "application/json";
  $axios.defaults.headers["Content-Type"] = "application/json";
}