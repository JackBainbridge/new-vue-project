<template>
    <SearchBar @input="onSearchInput" @search="onSearchSubmit" />
</template>
<script>
import { ref } from 'vue'
import SearchBar from '../components/SearchBar.vue';

export default {
  name: 'NavBar',
  components: {
    SearchBar,
  },
  setup() {
    const onSearchInput = (query) => {
      console.log('Search query changed:', query);
      // Handle input change (e.g., show suggestions)
    };

    const onSearchSubmit = (query) => {
      console.log('Search submitted:', query);
      // Handle search submission (e.g., navigate to search results page)
    };

    return {
      onSearchInput,
      onSearchSubmit,
    };
  },
};

//export default {
//    data() {
//        return {
//            item: {}
//        }
//    },
//    methods: {
//        fetchData() {
//			const response = fetch('https://api.coindesk.com/v1/bpi/currentprice.json', {
//				method: 'GET'
//			})
//            .then(response => response.json())
//            .then(data => this.item = data)
//            .catch(err => {
//                console.error(err);
//            });
//            console.log(response);
//		}
//    }
//}
</script>