<!-- SearchBar.vue -->
<template>
<div class="search-bar">
    <input
    type="text"
    v-model="searchQuery"
    @input="onInput"
    @keyup.enter="onSearch"
    placeholder="Search..."
    class="search-input"
    />
    <button @click="onSearch" class="search-button">
    Search
    </button>
</div>
</template>

<script>
import { ref } from 'vue';

export default {
    name: 'SearchBar',
        setup(props, { emit }) {
            const searchQuery = ref('');

            const onInput = () => {
                emit('input', searchQuery.value);
            };

            const onSearch = () => {
                emit('search', searchQuery.value);
            };

            return {
                searchQuery,
                onInput,
                onSearch,
            };
        }
};
</script>

<style scoped>
.search-bar {
display: flex;
align-items: center;
}

.search-input {
padding: 8px;
border: 1px solid #ccc;
border-radius: 4px 0 0 4px;
font-size: 16px;
}

.search-button {
padding: 8px 16px;
background-color: #4CAF50;
color: white;
border: none;
border-radius: 0 4px 4px 0;
cursor: pointer;
font-size: 16px;
}

.search-button:hover {
background-color: #45a049;
}
</style>