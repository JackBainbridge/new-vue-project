<template>
  <div>
    <!-- Top Gainers -->
    <h2 class="header2">Top Gainers</h2>

    <div v-if="isLoadingGainers">Loading...</div>
    <div v-else-if="errorGainers || topGainers.length === 0">
      <NoDataIcon />
    </div>
    <div v-else class="stock-panel-containers">
      <CircularButton
        direction="left"
        :disabled="!hasPreviousGainers"
        @click="showPreviousGainers"
      />
      <div class="stock-panel-wrapper" style="transform: gainerTransform">
        <TransitionGroup 
          name="group-slide-gainers"
          move-class="group-slide-gainers-move">
          <StockPanel
            v-for="(gainer, index) in visibleGainers"
            :key="gainer.ticker + '-' + index"
            :ticker="gainer.ticker"
            :price="gainer.price"
            :changeAmount="gainer.changeAmount"
            :changePercentage="gainer.changePercentage"
            :formatPrice="formatPrice"
            :formatChangeAmount="formatChangeAmount"
            :formatPercentage="formatPercentage"
          />
        </TransitionGroup>
      </div>
      <CircularButton 
        direction="right" 
        :disabled="!hasMoreGainers" 
        @click="showNextGainers" 
      />
    </div>
  </div>

  <div>
    <!-- Top Losers -->
    <h2 class="header2">Top Losers</h2>

    <div v-if="isLoadingGainers">Loading...</div>
    <div v-else-if="errorGainers || topGainers.length === 0">
      <NoDataIcon />
    </div>
    <div v-else class="stock-panel-containers">
      <CircularButton
        direction="left"
        :disabled="!hasPreviousLosers"
        @click="showPreviousLosers"
      />
      <TransitionGroup 
        name="group-slide-losers"
        move-class="group-slide-losers-move"
      >
        <StockPanel
          class="stock-panel"
          v-for="(loser, index) in visibleLosers"
            :key="loser.ticker + '-' + index"
            :ticker="loser.ticker"
            :price="loser.price"
            :changeAmount="loser.changeAmount"
            :changePercentage="loser.changePercentage"
            :formatPrice="formatPrice"
            :formatChangeAmount="formatChangeAmount"
            :formatPercentage="formatPercentage"
        />
      </TransitionGroup>
      <CircularButton direction="right" :disabled="!hasMoreLosers" @click="showNextLosers" />
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted, nextTick } from 'vue'
import { useTopGainers } from '@/composables/useTopGainers'
import StockPanel from '@/components/StockPanel.vue'
import CircularButton from '@/components/CircularButton.vue'
import NoDataIcon from '@/components/NoDataIcon.vue'
import { useTopLosers } from '@/composables/useTopLosers';

export default {
  components: {
    StockPanel,
    CircularButton,
    NoDataIcon
  },
  setup() {
    const { topGainers, isLoadingGainers, errorGainers, fetchTopGainers } = useTopGainers()
    const { topLosers, isLoadingLosers, errorLosers, fetchTopLosers } = useTopLosers()
    const currentGainerIndex = ref(0)
    const currentLoserIndex = ref(0)
    const panelWidth = ref(0)
    const itemsPerPage = 5

    // GAINERS
    const visibleGainers = computed(() => {
      return topGainers.value.slice(currentGainerIndex.value, currentGainerIndex.value + itemsPerPage)
    })

    const hasMoreGainers = computed(() => {
      return currentGainerIndex.value + itemsPerPage < topGainers.value.length
    })

    const hasPreviousGainers = computed(() => {
      return currentGainerIndex.value - itemsPerPage >= 0
    })

    const showNextGainers = () => {
      if (hasMoreGainers.value) {
        currentGainerIndex.value += itemsPerPage
      }
    }

    const showPreviousGainers = () => {
      if (hasPreviousGainers.value) {
        currentGainerIndex.value -= itemsPerPage
      }
    }

    // LOSERS
    const visibleLosers = computed(() => {
      return topLosers.value.slice(currentLoserIndex.value, currentLoserIndex.value + itemsPerPage)
    })

    const hasMoreLosers = computed(() => {
      return currentLoserIndex.value + itemsPerPage < topLosers.value.length
    })

    const hasPreviousLosers = computed(() => {
      return currentLoserIndex.value - itemsPerPage >= 0
    })

    const showNextLosers = () => {
      if (hasMoreLosers.value) {
        currentLoserIndex.value += itemsPerPage
      }
    }

    const showPreviousLosers = () => {
      if (hasPreviousLosers.value) {
        currentLoserIndex.value -= itemsPerPage
      }
    }

    const gainerTransform = computed(() => {
      return `translateX(-${currentGainerIndex.value * (100 / itemsPerPage)}%)`;
    });

    // Fetch data when the component is mounted
    onMounted(async () => {
      await nextTick()
      const panelElement = document.querySelector('.stock-panel')
      if (panelElement) {
        panelWidth.value = panelElement.offsetWidth
      }
      fetchTopGainers()
      fetchTopLosers()
    })

    // Formatting methods for display
    const formatPrice = (price) => (price ? `$${price.toFixed(2)}` : 'N/A')
    const formatChangeAmount = (change_amount) =>
      change_amount ? `$${change_amount.toFixed(2)}` : 'N/A'
    const formatPercentage = (changePercentage) =>
      changePercentage ? `${changePercentage.toFixed(2)}%` : 'N/A'

    return {
      StockPanel,
      CircularButton,
      topGainers,
      isLoadingGainers,
      errorGainers,
      topLosers,
      isLoadingLosers,
      errorLosers,
      formatPrice,
      formatChangeAmount,
      formatPercentage,
      visibleGainers,
      showNextGainers,
      showPreviousGainers,
      hasMoreGainers,
      hasPreviousGainers,
      visibleLosers,
      showNextLosers,
      showPreviousLosers,
      hasMoreLosers,
      hasPreviousLosers,
      panelWidth,
      currentGainerIndex,
      currentLoserIndex,
    }
  },
}
</script>

<style scoped>
.header2 {
  color: var(--white);
  text-align: center;
  font-size: 250%;
}

/* Horizontal container for stock panels */
.stock-panel-containers {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center; /* Center the content horizontally */
  gap: 20px;
  padding: 20px 0;
  overflow-x: hidden; /* Hide horizontal overflow */
  width: 100%; /* Ensure full width */
}

.stock-panel-wrapper {
  display: flex;
  flex-direction: row;
  gap: 20px;
  transition: transform 0.5s ease; /* For smooth sliding effect */
}

.stock-panel {
  flex: 0 0 auto; /* Don't allow panels to grow or shrink */
  width: 200px; /* Set a fixed width for each panel, adjust as needed */
  box-shadow: 10px 5px 5px var(--black);
  transition: transform 0.5s ease;
}

.stock-panel:hover {
  transform: translateY(5px);
  transform: scale(1.05);
}
</style>
