#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>
#include <SDL2/SDL_mixer.h>
#include <SDL2/SDL_ttf.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <windows.h>

#define WINDOW_WIDTH 500
#define WINDOW_HEIGHT 500
#define DOT_RADIUS 15

SDL_Window* window = NULL;
SDL_Renderer* renderer = NULL;
TTF_Font* font = NULL;
Mix_Chunk* clickSound = NULL;

SDL_Point dot;
bool showDot = true;
int score = 0;
Uint32 startTime = 0;
bool isPaused = false;
Uint32 pausedTime = 0;

void generateRandomDot() {
    int safeMarginTop = 100; // Avoid overlapping score/time text
    do {
        dot.x = rand() % (WINDOW_WIDTH - 2 * DOT_RADIUS) + DOT_RADIUS;
        dot.y = rand() % (WINDOW_HEIGHT - 2 * DOT_RADIUS - safeMarginTop) + DOT_RADIUS + safeMarginTop;
    } while (dot.y < safeMarginTop); // Ensure it's below safe margin
}

void renderText(const char* text, int x, int y, SDL_Color color) {
    SDL_Surface* surface = TTF_RenderText_Solid(font, text, color);
    SDL_Texture* texture = SDL_CreateTextureFromSurface(renderer, surface);
    SDL_Rect dst = { x, y, surface->w, surface->h };
    SDL_RenderCopy(renderer, texture, NULL, &dst);
    SDL_FreeSurface(surface);
    SDL_DestroyTexture(texture);
}

void drawFilledCircle(SDL_Renderer* renderer, int x0, int y0, int radius) {
    for (int y = -radius; y <= radius; y++) {
        for (int x = -radius; x <= radius; x++) {
            if (x * x + y * y <= radius * radius) {
                SDL_RenderDrawPoint(renderer, x0 + x, y0 + y);
            }
        }
    }
}

bool isDotClicked(int mouseX, int mouseY) {
    int dx = mouseX - dot.x;
    int dy = mouseY - dot.y;
    return dx * dx + dy * dy <= DOT_RADIUS * DOT_RADIUS;
}

int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd){
    srand(time(NULL));
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) != 0) {
        printf("SDL Init Error: %s\n", SDL_GetError());
        return 1;
    }
    if (TTF_Init() != 0) {
        printf("TTF Init Error: %s\n", TTF_GetError());
        return 1;
    }
    if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048) < 0) {
        printf("SDL Mixer Error: %s\n", Mix_GetError());
        return 1;
    }

    window = SDL_CreateWindow("Aim Game", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                              WINDOW_WIDTH, WINDOW_HEIGHT, SDL_WINDOW_SHOWN);
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    font = TTF_OpenFont("font.otf", 24);
    if (!font) {
        printf("Failed to load font: %s\n", TTF_GetError());
        return 1;
    }

    clickSound = Mix_LoadWAV("sound.mp3");
    if (!clickSound) {
        printf("Failed to load sound: %s\n", Mix_GetError());
        return 1;
    }

    generateRandomDot();
    startTime = SDL_GetTicks();

    SDL_Event e;
    bool running = true;

    while (running) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                running = false;
            }

            if (e.type == SDL_KEYDOWN) {
                if (e.key.keysym.sym == SDLK_p) {
                    isPaused = true;
                    pausedTime = SDL_GetTicks();
                } else if (e.key.keysym.sym == SDLK_r) {
                    isPaused = false;
                    Uint32 resumeTime = SDL_GetTicks();
                    startTime += resumeTime - pausedTime;
                }
            }

            if (!isPaused && e.type == SDL_MOUSEBUTTONDOWN) {
                int mx = e.button.x;
                int my = e.button.y;
                if (isDotClicked(mx, my)) {
                    score++;
                    Mix_PlayChannel(-1, clickSound, 0);
                    generateRandomDot();
                }
            }
        }

        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
        SDL_RenderClear(renderer);

        if (!isPaused && showDot) {
            SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
            drawFilledCircle(renderer, dot.x, dot.y, DOT_RADIUS);
        }

        SDL_Color black = { 0, 0, 0 };

        // Score text
        char scoreText[64];
        snprintf(scoreText, sizeof(scoreText), "Score: %d", score);
        renderText(scoreText, 20, 20, black);

        // Time text
        Uint32 elapsedTime = (isPaused ? pausedTime : SDL_GetTicks()) - startTime;
        char timeText[64];
        snprintf(timeText, sizeof(timeText), "Time: %.2f sec", elapsedTime / 1000.0f);
        renderText(timeText, 20, 60, black);

        // Result message when paused
        if (isPaused) {
            char resultText[128];
            snprintf(resultText, sizeof(resultText), "Paused - Final Score: %d | Time: %.2f sec", score, elapsedTime / 1000.0f);
            renderText(resultText, 50, 200, black);
            renderText("Press R to Resume", 130, 240, black);
        }

        SDL_RenderPresent(renderer);
        SDL_Delay(16); // ~60 FPS
    }

    Mix_FreeChunk(clickSound);
    TTF_CloseFont(font);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    Mix_CloseAudio();
    TTF_Quit();
    SDL_Quit();
    return 0;
}
