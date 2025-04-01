<template>
    <div>
        <h1>News for {{ ticker }}</h1>
        <div v-if="isLoading">Loading...</div>
        <div v-else-if="error"> 
            <NoDataIcon />
        </div>
        <!-- Display item news information -->
        <ul v-else>
            <h2>Sentiment Score Definition</h2>
            <p>{{ sentimentScoreDefinition }}</p>

            <h2>Relevance Score Definition</h2>
            <p>{{ relevanceScoreDefinition }}</p>

            <h2>Feed Items</h2>
            <ul>
                <li v-for="(item, index) in feed" :key="index">
                    {{ item }}
                </li>
            </ul>
        </ul>
    </div>
</template>

<script>
  import NoDataIcon from '@/components/NoDataIcon.vue'
  import { ref, onMounted } from 'vue';
  import axios from 'axios';
  
  export default {
    components: {
      NoDataIcon,
    },
    props: ['ticker'],
    setup(props) {
      const isLoading = ref(true);
      const error = ref(null);
      const feed = ref([]);
      const sentimentScoreDefinition = ref('');
      const relevanceScoreDefinition = ref('');
      const fetchNews = async () => {
      try {
        const response = await axios.get(
          `https://www.alphavantage.co/query?function=NEWS_SENTIMENT&symbol=${props.ticker}&apikey=41DRJL8FNHB0I8XL`
        );
        const data = response.data;
        feed.value = data.feed || [];
        sentimentScoreDefinition.value =
          data.sentiment_score_definition || 'No sentiment score definition available.';
        relevanceScoreDefinition.value =
          data.relevance_score_definition || 'No relevance score definition available.';
      } catch (err) {
        console.error(err);
        error.value = 'Failed to fetch news data.';
      } finally {
        isLoading.value = false;
      }
    };
  
      onMounted(fetchNews);  
      return { 
        error: null,
        feed,
        isLoading,
        fetchNews,
        ticker: props.ticker,
        error,
        sentimentScoreDefinition,
        relevanceScoreDefinition,
        };
    },
  };
</script>
  
<style scoped>
  
h1 {
    text-align: center;
    color: var(--white);
    font-size: 250%;
}

h2 {
    text-align: center;
    color: var(--white);
    font-size: 150%;
}

ul {
    list-style-type: none;
}
li {
    margin-bottom: 10px;
}
</style>
  