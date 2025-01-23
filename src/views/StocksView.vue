<template>
  <div>
    <h2>Top Gainers</h2>

    <!-- Loading State -->
    <div v-if="isLoading">Loading...</div>

    <!-- Error State -->
    <div v-if="error" class="error">{{ error }}</div>

    <!-- Data Table -->
    <StockPanel
      v-for="(gainer, index) in topGainers"
      :key="index"
      :ticker="gainer.ticker"
      :price="gainer.price"
      :changeAmount="gainer.changeAmount"
      :changePercentage="gainer.changePercentage"
      :formatPrice="formatPrice"
      :formatChangeAmount="formatChangeAmount"
      :formatPercentage="formatPercentage"
    />
  </div>
</template>

<script>
import { onMounted } from 'vue'
import { useTopGainers } from '@/composables/useTopGainers'
import StockPanel from '@/components/StockPanel.vue'

export default {
  components: {
    StockPanel,
  },
  setup() {
    const { topGainers, isLoading, error, fetchTopGainers } = useTopGainers()

    // Fetch data when the component is mounted
    onMounted(() => {
      fetchTopGainers()
    })

    // Formatting methods for display
    const formatPrice = (price) => (price ? `$${price.toFixed(2)}` : 'N/A')
    const formatChangeAmount = (change_amount) =>
      change_amount ? `$${change_amount.toFixed(2)}` : 'N/A'
    const formatPercentage = (changePercentage) =>
      changePercentage ? `${changePercentage.toFixed(2)}%` : 'N/A'

    return {
      topGainers,
      isLoading,
      error,
      formatPrice,
      formatChangeAmount,
      formatPercentage,
      StockPanel,
    }
  },
}
</script>
