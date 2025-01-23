import { ref } from 'vue'

export function useTopGainers() {
  const topGainers = ref([])
  const isLoading = ref(false)
  const error = ref(null)

  const fetchTopGainers = async () => {
    isLoading.value = true
    error.value = null

    try {
      const response = await fetch('http://localhost:8082/api/top-gainers')
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`)
      }
      topGainers.value = await response.json()
    } catch (err) {
      error.value = err.message
      console.error('Error fetching top gainers:', err)
    } finally {
      isLoading.value = false
    }
  }

  return {
    topGainers,
    isLoading,
    error,
    fetchTopGainers,
  }
}
