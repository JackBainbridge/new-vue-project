import { ref } from 'vue'

export function useTopLosers() {
  const topLosers = ref([])
  const isLoading = ref(false)
  const error = ref(null)

  const fetchTopLosers = async () => {
    isLoading.value = true
    error.value = null

    try {
      const response = await fetch('http://localhost:8082/api/top-losers')
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`)
      }
      topLosers.value = await response.json()
    } catch (err) {
      console.error('Error fetching top gainers:', err)
      error.value = err.message
      topLosers.value = []
    } finally {
      isLoading.value = false
    }
  }

  return {
    topLosers,
    isLoading,
    error,
    fetchTopLosers,
  }
}
